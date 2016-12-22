Received: from eggs.gnu.org ([2001:4830:134:3::10]:37352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK8y4-0004vG-8P
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK8y3-0004Nv-9J
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:23:56 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cK8y3-0004Nb-3y
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:23:55 -0500
Received: by mail-ua0-x22a.google.com with SMTP id 2so116254265uax.2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 11:23:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222104740.19606-1-berrange@redhat.com>
References: <20161222104740.19606-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Dec 2016 19:23:34 +0000
Message-ID: <CAFEAcA-A3jD7EFvo5sio5F5f4=EjByyZHj6exXzPHk-YibKCSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/8] Merge qcrypto 2016-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 December 2016 at 10:47, Daniel P. Berrange <berrange@redhat.com> wrot=
e:
> The following changes since commit 82ecffa8c050bf5bbc13329e9b65eac1caa5b5=
5c:
>
>   Open 2.9 development tree (2016-12-20 16:20:16 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu pull-qcrypto-2016-12-21-2
>
> for you to fetch changes up to 4fd460bf25b197f94b9db463b77a69433901ac92:
>
>   crypto: add HMAC algorithms testcases (2016-12-22 09:24:59 +0000)
>
> ----------------------------------------------------------------
> Merge qcrypto 2016/12/21 v2
>
> ----------------------------------------------------------------
>
> Longpeng(Mike) (7):
>   crypto: add 3des-ede support when using libgcrypt/nettle
>   configure: add CONFIG_GCRYPT_HMAC item
>   crypto: add HMAC algorithms framework
>   crypto: support HMAC algorithms based on libgcrypt
>   crypto: support HMAC algorithms based on glib
>   crypto: support HMAC algorithms based on nettle
>   crypto: add HMAC algorithms testcases
>
> Marc-Andr=C3=A9 Lureau (1):
>   cipher: fix leak on initialization error

Applied, thanks.

-- PMM
