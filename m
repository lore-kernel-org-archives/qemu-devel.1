Received: from eggs.gnu.org ([2001:4830:134:3::10]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpAlS-0003Z4-8g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpAlN-00062W-GM
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:07:26 -0400
Date: Tue, 5 Sep 2017 11:07:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905100715.GI17449@stefanha-x1.localdomain>
References: <20170831105456.9558-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831105456.9558-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] block: document semantics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu, Aug 31, 2017 at 11:54:56AM +0100, Daniel P. Berrange wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 
> Changed in v4:
> 
>   - Fix typo in commit message
> 
>  include/block/block_int.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan
