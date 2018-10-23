Received: from eggs.gnu.org ([2001:4830:134:3::10]:45707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEwP1-0003WW-3Z
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEwOq-0006N4-VL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:07:15 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEwOn-0006HW-5x
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:07:07 -0400
Received: by mail-oi1-x234.google.com with SMTP id u74-v6so1010572oia.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:07:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019134318.17155-1-berrange@redhat.com>
References: <20181019134318.17155-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 14:06:40 +0100
Message-ID: <CAFEAcA8LNep6uZEhxHeJV2WqskK_9Mj2uwhiXMTb0QJnGrz6hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 14:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> The following changes since commit 2ec24af2379e331d062a6fc1cda65bc262c7c1=
7b:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-october=
-2018-part1-v2' into staging (2018-10-19 10:08:31 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to 64dd2f3b5b090c21c3e82142de3fe7b4793ce6c8:
>
>   crypto: require nettle >=3D 2.7.1 for building QEMU (2018-10-19 14:41:4=
7 +0100)
>
> ----------------------------------------------------------------
> Update min required crypto library versions
>
> The min required versions for crypto libraries are now
>
>  - gnutls >=3D 3.1.18
>  - nettle >=3D 2.7.1
>  - libgcrypt >=3D 1.5.0
>

Applied, thanks.

-- PMM
