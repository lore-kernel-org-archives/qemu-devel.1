Received: from eggs.gnu.org ([2001:4830:134:3::10]:49916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFmgx-0005Yb-RP
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFmgx-00040k-9K
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:52:47 -0500
Date: Fri, 17 Nov 2017 20:52:35 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171117195235.3szaagk5dy7v7pte@eukaryote>
References: <20171117185444.4947-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117185444.4947-1-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-2.11] QAPI & interop: Clarify events
 emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com

On Fri, Nov 17, 2017 at 07:54:44PM +0100, Kashyap Chamarthy wrote:
> When you cancel an in-progress 'mirror' job (or "active `block-commit`)

When applying, can the maintainer please fix-up the missing closing
double-quote in the brackets above?  It should be: "active
`block-commit`"

[...]

-- 
/kashyap
