Received: from eggs.gnu.org ([2001:4830:134:3::10]:33153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e58iQ-0005EP-AT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e58iM-0005fr-CV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:10:18 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:54227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e58iM-0005f8-5K
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:10:14 -0400
Received: by mail-wr0-x236.google.com with SMTP id u40so2032644wrf.10
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 04:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171017082502.7885-1-kraxel@redhat.com>
References: <20171017082502.7885-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 12:09:52 +0100
Message-ID: <CAFEAcA_42+22DtNAT33VjYDVB3znjrRrLhtmDwxZ_7Fp=GFPgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Vga 20171017 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 October 2017 at 09:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit c5bbcaa4b7c0f8a322bebe9ec563560178a68b55:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-10-16 17:29:16 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20171017-pull-request
>
> for you to fetch changes up to eb38e1bc3740725ca29a535351de94107ec58d51:
>
>   cirrus: fix oob access in mode4and5 write functions (2017-10-17 09:59:00 +0200)
>
> ----------------------------------------------------------------
> cirrus: bugfixes, with some vga cleanups.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (4):
>   vga: drop line_offset variable
>   vga: handle cirrus vbe mode wraparounds.
>   vga: add ram_addr_t cast
>   cirrus: fix oob access in mode4and5 write functions
>

Applied, thanks.

-- PMM
