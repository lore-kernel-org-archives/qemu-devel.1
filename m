Received: from eggs.gnu.org ([2001:4830:134:3::10]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAZb9-00019I-A1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAZb8-0005OM-Lw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:57:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAZb8-0005Ny-7w
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:57:46 -0400
Received: by mail-ot1-x343.google.com with SMTP id l1so8611777otj.5
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 04:57:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181010061113.6057-1-armbru@redhat.com>
References: <20181010061113.6057-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 12:57:25 +0100
Message-ID: <CAFEAcA_xdNCbgNWcyyF4OUbM2xmMAU-0hTdnx3WwAnWPRZL5VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Miscellaneous patches for 2018-10-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 October 2018 at 07:11, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 7c69b7c849641a39ba3defa40d384a2ba24cd7a2:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181008' into staging (2018-10-08 15:01:30 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-10-10
>
> for you to fetch changes up to b266f1d1123396f9f5df865508f7555ab0c9582a:
>
>   ivshmem: Fix unplug of device "ivshmem-plain" (2018-10-10 08:01:36 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-10-10
>
> * Fix ivshmem unplug (regressed in v2.7.0)
> * Minor test suite and doc work
>

Applied, thanks.

-- PMM
