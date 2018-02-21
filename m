Received: from eggs.gnu.org ([2001:4830:134:3::10]:55946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eobRU-0007hY-HP
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eobQQ-0004oR-H9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:56:44 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71f011e1-9417-97a9-ba59-4348c2c6ff71@redhat.com>
Date: Wed, 21 Feb 2018 14:53:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/36] test-qemu-opts: Test
 qemu_opts_append()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> Basic test for merging two QemuOptsLists.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/test-qemu-opts.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 128 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
