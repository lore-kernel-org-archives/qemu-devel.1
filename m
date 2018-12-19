Received: from eggs.gnu.org ([2001:4830:134:3::10]:54225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZX93-0007gQ-Hx
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZX90-0002vU-Cq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:23:57 -0500
References: <20181115211752.1295571-1-eblake@redhat.com>
	<20181115211752.1295571-2-eblake@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <79cb1a33-0237-c321-d5f7-1b7586363613@vivier.eu>
Date: Wed, 19 Dec 2018 09:23:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181115211752.1295571-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/2] typedefs: (Re-)sort
 entries alphabetically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

On 15/11/2018 22:17, Eric Blake wrote:
> Since the last time we sorted things (2988cbeaf), we've had a
> few relapses that were inserted out of order.  Also, we had more
> entries that were sorted case-insensitively than not, so let's
> document that convention and stick to it.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qemu/typedefs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
