Received: from eggs.gnu.org ([2001:4830:134:3::10]:51861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddHrv-00047r-5Y
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddHru-0007bK-C5
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:16:59 -0400
Date: Thu, 3 Aug 2017 17:16:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803151650.GK4456@dhcp-200-186.str.redhat.com>
References: <20170728164708.12202-1-eblake@redhat.com>
	<20170728164708.12202-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728164708.12202-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qemu-io: Give more --version
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

Am 28.07.2017 um 18:47 hat Eric Blake geschrieben:
> Include the package version information (useful for detecting
> builds from git or downstream backports), and the copyright notice.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Acked-by: Kevin Wolf <kwolf@redhat.com>
