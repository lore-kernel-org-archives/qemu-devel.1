Received: from eggs.gnu.org ([2001:4830:134:3::10]:59898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUTZ-0006J6-Sq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUTZ-0006Lt-72
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:43:53 -0400
References: <20180321173714.14741-1-kwolf@redhat.com>
	<20180321173714.14741-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <508b3d16-ba80-6464-66f2-7f3200df518d@redhat.com>
Date: Fri, 23 Mar 2018 16:43:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180321173714.14741-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2 03/12] qemu-iotests: Test vdi
 image creation with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/21/2018 12:37 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/211     | 246 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/211.out |  97 ++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 344 insertions(+)
>   create mode 100755 tests/qemu-iotests/211
>   create mode 100644 tests/qemu-iotests/211.out
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
