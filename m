Received: from eggs.gnu.org ([2001:4830:134:3::10]:36245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e48GP-0000cz-2C
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e48GO-0002tt-4c
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:29:13 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:48647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e48GN-0002rf-U8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:29:12 -0400
Received: by mail-wm0-x229.google.com with SMTP id i124so5073701wmf.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 09:29:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2017 17:28:50 +0100
Message-ID: <CAFEAcA_ypGCq_xdrqyNsiriskxOf4a58oYaZAGfTQw9as2e_wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9] NBD patches through 14 Oct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 October 2017 at 01:40, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57=
d6:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
71012' into staging (2017-10-12 17:06:50 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-10-14
>
> for you to fetch changes up to 92652b124336f5c08c7eb4616af202ea910dd3ea:
>
>   nbd: header constants indenting (2017-10-13 09:27:38 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-10-14
>
> - Marc-Andr=C3=A9 Lureau - NBD: use g_new() family of functions
> - Vladimir Sementsov-Ogievskiy - first half of 00/13 nbd minimal structur=
ed read
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
