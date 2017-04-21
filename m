Received: from eggs.gnu.org ([2001:4830:134:3::10]:51117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1YsJ-00043j-Pr
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1YsJ-0001n2-2V
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:45:27 -0400
Date: Fri, 21 Apr 2017 15:45:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170421134513.GE4318@noname.redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421035606.448-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 06/20] qemu-io: Add --share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> Add --share-rw/-U to program options and -U to open subcommand.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
