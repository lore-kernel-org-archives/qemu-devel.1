Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gEbeK-00076u-5a
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gEbeJ-00060c-41
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:57:44 -0400
References: <20181019163013.11787-1-kwolf@redhat.com>
	<20181020193107.11369-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5af887ce-4359-99c1-0532-895f003efe48@redhat.com>
Date: Mon, 22 Oct 2018 13:14:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181020193107.11369-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/11] qemu-iotests: Test auto-read-only
 with -drive and -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/20/18 8:31 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/232     | 147 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/232.out |  59 +++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 207 insertions(+)
>   create mode 100755 tests/qemu-iotests/232
>   create mode 100644 tests/qemu-iotests/232.out

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
