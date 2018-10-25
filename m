Received: from eggs.gnu.org ([2001:4830:134:3::10]:55306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFihj-00064m-SR
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFihi-0002Yy-VR
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:41:51 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:44915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFihi-0002YU-Pl
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:41:50 -0400
Received: by mail-oi1-x235.google.com with SMTP id k19-v6so1210961oic.11
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:41:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024180547.20429-1-berrange@redhat.com>
References: <20181024180547.20429-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Oct 2018 17:41:28 +0100
Message-ID: <CAFEAcA-ZXTE1Aw2pZveXiH6QXGJvBuoAgJgYo=Yi9Lr82Z4xRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] Qcrypto next patches
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

On 24 October 2018 at 19:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> The following changes since commit c96292036a17857d62b8b5d3c8752bac3d6b71=
93:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-201=
8-part-2-v2' into staging (2018-10-24 16:31:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to 1e0fa32c6c952d2ce9c19d35717c609804dd55d5:
>
>   crypto: add testing for unaligned buffers with XTS cipher mode (2018-10=
-24 19:03:37 +0100)
>
> ----------------------------------------------------------------
> Improve performance of XTS cipher mode impl
>
> The XTS cipher mode performance is approximately doubled and test
> coverage is improved.
>
> ----------------------------------------------------------------



Applied, thanks.

-- PMM
