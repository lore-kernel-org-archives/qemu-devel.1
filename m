Received: from eggs.gnu.org ([2001:4830:134:3::10]:38970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eWebR-0005GJ-Gm
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eWebO-0007OX-Da
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:40:49 -0500
Date: Wed, 3 Jan 2018 09:40:35 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180103084034.txfni6uchru7kdgx@eukaryote>
References: <20171226025247.11082-1-famz@redhat.com>
	<20171226025247.11082-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171226025247.11082-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qemu-img.texi: Clean up parameter
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

On Tue, Dec 26, 2017 at 10:52:46AM +0800, Fam Zheng wrote:
> Split options out of the "@table @var" section and create a "@table
> @option", then use whitespaces and blank lines consistently.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.texi | 66 +++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 27 deletions(-)

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
