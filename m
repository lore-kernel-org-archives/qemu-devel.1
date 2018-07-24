Received: from eggs.gnu.org ([2001:4830:134:3::10]:36318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz0g-0005MS-7x
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz0a-0007JN-JI
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:13:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhz0a-0007IZ-Cw
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:13:52 -0400
References: <20180724142504.15092-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b1ef4d8-c938-0e3c-2d6a-933fb1e309f7@redhat.com>
Date: Tue, 24 Jul 2018 10:13:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180724142504.15092-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 07/24/2018 09:25 AM, Stefan Hajnoczi wrote:
> The following changes since commit 768cef2974fb1fa30dd188b043ea737e13fea477:
> 
>    Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-07-24 10:37:52 +0100)
> 
> are available in the Git repository at:
> 
>    git://github.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to b6ad6a528f2356b357bd1d210048dd7988dc9a7b:
> 
>    trace/simple: fix hang in child after fork(2) (2018-07-24 14:27:51 +0100)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Fix qemu-iotests 147 when QEMU was built with ./configure --enable-trace-backend=simple.

Design conversation ongoing under patch 1/1 - replying here to make sure 
this doesn't get applied if we aren't ready for it yet.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
