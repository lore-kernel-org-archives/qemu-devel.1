Received: from eggs.gnu.org ([2001:4830:134:3::10]:46036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dTBFJ-0007Hb-Oy
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dTBFJ-0006y4-0R
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:11:21 -0400
Date: Thu, 6 Jul 2017 20:11:10 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170706181110.jcnd3xf63qpf5ktn@eukaryote>
References: <1499351806-3359-1-git-send-email-kchamart@redhat.com>
	<1499351806-3359-3-git-send-email-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499351806-3359-3-git-send-email-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Thu, Jul 06, 2017 at 04:36:46PM +0200, Kashyap Chamarthy wrote:
> This patch documents (including their QMP invocations) all the four
> major kinds of live block operations:

[...]

> (cherry picked from commit aef3e734f2d30b97e29345943d9e1cab794d0846)

Oops, the above "cherry picked" line is accidental -- as I was doing
some local branch wrangling.  It can be removed when applying the patch.
If the maintainer asks, I can respin.  But I'll first wait for any other
feedback, if there is.

> ---
>  docs/interop/live-block-operations.rst | 1072 ++++++++++++++++++++++++++++++++
>  docs/live-block-ops.txt                |   72 ---
>  2 files changed, 1072 insertions(+), 72 deletions(-)
>  create mode 100644 docs/interop/live-block-operations.rst
>  delete mode 100644 docs/live-block-ops.txt

[...]

-- 
/kashyap
