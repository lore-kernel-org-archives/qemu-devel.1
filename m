Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNTzO-0004zm-6w
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNTzN-0000C4-GC
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:31:38 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-17-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9efa3fc4-e9ce-4e08-c2c7-4db3eb81a026@redhat.com>
Date: Fri, 8 Dec 2017 20:31:28 -0500
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-17-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/17] iotests: Make 191 work with qcow2
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 11/22/2017 09:08 PM, Max Reitz wrote:
> In order for 191 to work with an explicit refcount_bits or compat=0.10,
> we should strip format-specific information from the output--and we can
> do so by using _filter_img_info.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/191     |   5 +-

"Looks good!"

>  tests/qemu-iotests/191.out | 313 +++++++++++++--------------------------------

AAAAAAAA

* just runs the test instead *

Reviewed-by: John Snow <jsnow@redhat.com>
