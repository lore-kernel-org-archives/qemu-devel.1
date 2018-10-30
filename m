Received: from eggs.gnu.org ([2001:4830:134:3::10]:32981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHYD5-00086u-UT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHYD2-0005IJ-T1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:53:47 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHYD2-0005HL-14
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:53:44 -0400
Received: by mail-oi1-x231.google.com with SMTP id v198-v6so8455145oif.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:53:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f1b976d-e1ce-44bc-2810-ff7a3275d6ac@redhat.com>
References: <1540920498-5133-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<2f1b976d-e1ce-44bc-2810-ff7a3275d6ac@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 17:53:21 +0000
Message-ID: <CAFEAcA8e2p9mEBeXLAd_ZZn0Cbj_34ykPY=ubFDvxqVKAfZfZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] MIPS queue for October 2018, part 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 30 October 2018 at 17:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> 1h44min between a series posted and the same series sent as pull request =
is
> quite fast for qemu-devel@.
>
> I'm sorry to complain about this, but this is not the first time I review
> your patches and make comment, and see the previous series in PR and my
> comment ignored.
>
> There are (paid) reviewers working in about every timezones, also note th=
at
> some hobbyist might only have time during week-ends.
>
> I don't know if they are guidelines for that. 24h could work.

We don't have specific guidelines, but yes, in general there should
be a reasonable time between patches being posted and their being
applied, to allow time for review. There is some element of a
judgement call here -- if the patch is "obviously" non-controversial
or trivial and it gets reviewed quickly it may be ok to put it into
a pull request sooner rather than later. And I appreciate that it
being softfreeze day today imposes some time pressure.

I think in this case it would be good to let these have a bit more
time and to handle the code review comments; we can still put them
into 3.1.

thanks
-- PMM
