import { ButtonLink } from '@/components/Button';
import { Container, Spacer, Wrapper } from '@/components/Layout';
import Link from 'next/link';
import styles from './Hero.module.css';

const Hero = () => {
  return (
    <Wrapper>
      <div>
        <h1 className={styles.title}>
          <span className={styles.myJournal}>myJournal
          </span>
          <span></span>
        </h1>
        <Container justifyContent="center" className={styles.buttons}>
          <Container>
            <Link passHref href="/feed" legacyBehavior>
              <ButtonLink className={styles.button}>Explore Feed</ButtonLink>
            </Link>
          </Container>
          <Spacer axis="horizontal" size={1} />
          <Container>
            <ButtonLink
              href="https://github.com/msheldon70/nextjs-mongodb-app/tree/v2-proposal"
              type="secondary"
              className={styles.button}
            >
              GitHub
            </ButtonLink>
          </Container>
        </Container>
        <p className={styles.subtitle}>
          A Next.js and MongoDB web application, designed with simplicity for
          journaling and reflection.
        </p>
      </div>
    </Wrapper>
  );
};

export default Hero;
