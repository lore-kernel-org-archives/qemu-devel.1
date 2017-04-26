Received: from eggs.gnu.org ([2001:4830:134:3::10]:36670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3MRb-0005ZA-Ct
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3MRa-0005IV-LX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:19 -0400
Date: Wed, 26 Apr 2017 20:53:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170426125310.GA9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-22-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426033413.17192-22-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 21/21] qemu-iotests: Add test case 153
 for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 04/26 11:34, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/153     | 220 +++++++++++++++++++++++++
>  tests/qemu-iotests/153.out | 390 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 611 insertions(+)
>  create mode 100755 tests/qemu-iotests/153
>  create mode 100644 tests/qemu-iotests/153.out
> 
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> +== Creating /var/tmp/q/build/tests/qemu-iotests/scratch/t.qcow2.[abc] ==

Forgot to filter test dir here.

Fam
