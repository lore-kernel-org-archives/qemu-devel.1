Received: from eggs.gnu.org ([209.51.188.92]:39664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guDsu-0003Bv-Ko
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guDsq-0007Ps-Mh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:04:46 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:42373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guDsk-0006ud-Fj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:04:42 -0500
Received: by mail-ot1-x330.google.com with SMTP id i5so9498816oto.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20190212045721.28041-1-richard.henderson@linaro.org>
	<CAFEAcA_Oc4fTfcC-RFmV3zi7RnAbjDv=xWG8uPb_AT9buGnAcQ@mail.gmail.com>
	<46f22bec-d2ce-da2c-5aa0-c8572181f9ee@redhat.com>
In-Reply-To: <46f22bec-d2ce-da2c-5aa0-c8572181f9ee@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 10:04:06 +0000
Message-ID: <CAFEAcA9yvA5Vs-x3mYEJgn4aB7vN108Q7ek7jAnoNZtJ=K=mDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/24] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 13 Feb 2019 at 18:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> What Clang version is that?
>
> I can not reproduce using:
>
> clang version 7.0.1 (Fedora 7.0.1-1.fc29)

OSX: Apple LLVM version 10.0.0 (clang-1000.11.45.5)
and Ubuntu bionic: clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)

thanks
-- PMM
