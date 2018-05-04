Received: from eggs.gnu.org ([2001:4830:134:3::10]:60439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEa9A-0007zt-3L
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEa99-0007Eu-DH
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:49:12 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:36057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEa99-0007EP-7S
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:49:11 -0400
Received: by mail-ot0-x236.google.com with SMTP id m11-v6so18152395otf.3
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 05:49:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 13:48:49 +0100
Message-ID: <CAFEAcA9Mntorn6kt9n-9r8zQ-oBsGTT9Z1x3U=zrsZ6mtiWWEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] first s390x update for 2.13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 May 2018 at 08:24, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 6f0c4706b35dead265509115ddbd2a8d1af516c1:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180427-pull-request' into staging (2018-04-27 12:27:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180504
>
> for you to fetch changes up to 532cd4b067d37b96496dbacbfab6c990c063d33d:
>
>   Merge tag 'tags/s390x-2018-05-02' into staging (2018-05-03 16:33:01 +0200)
>
> ----------------------------------------------------------------
> First s390x pull request for 2.13.
> - new machine type
> - extend SCLP event masks
> - support configuration of consoles via -serial
> - firmware improvements: non-sequential entries in boot menu, support
>   for indirect loading via .INS files in s390-netboot
> - bugfixes and cleanups
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
