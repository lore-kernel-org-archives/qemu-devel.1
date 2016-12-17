Received: from eggs.gnu.org ([2001:4830:134:3::10]:59075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cID0W-0004Sm-F8
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 06:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cID0V-0007R2-Bz
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 06:18:28 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cID0U-0007P8-N9
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 06:18:27 -0500
Received: by mail-ua0-x230.google.com with SMTP id 12so61661222uas.2
	for <qemu-devel@nongnu.org>; Sat, 17 Dec 2016 03:18:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <148192392306.37.10111381964118487672@790289a7ca88>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Dec 2016 11:18:03 +0000
Message-ID: <CAFEAcA97bb-LBoPVvm_wqS6GVyYoFhwR6qBRJDPVRLG8sOGqsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 16 December 2016 at 21:32,  <no-reply@patchew.org> wrote:
> Your series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Subject: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
> Message-id: 1481922841-4324-1-git-send-email-mst@redhat.com

> Checking PATCH 5/9: contrib: add libvhost-user...
> ERROR: Invalid UTF-8, patch and commit message should be encoded in UTF-8
> #75: FILE: contrib/libvhost-user/libvhost-user.c:9:
> + *  Marc-Andr Lureau <mlureau@redhat.com>
>               ^
>
> ERROR: Invalid UTF-8, patch and commit message should be encoded in UTF-8
> #1579: FILE: contrib/libvhost-user/libvhost-user.h:8:
> + *  Marc-Andr Lureau <mlureau@redhat.com>
>               ^
>
> total: 2 errors, 0 warnings, 1950 lines checked

Michael, could you check the encoding in that file and respin
the patchset if necessary, please?

thanks
-- PMM
