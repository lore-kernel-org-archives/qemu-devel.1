Received: from eggs.gnu.org ([209.51.188.92]:33066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH1PN-0004G9-5l
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 03:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH1NF-000564-1T
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 03:22:21 -0400
Date: Thu, 18 Apr 2019 09:22:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190418072215.GA5242@linux.fritz.box>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 08.04.2019 um 16:35 hat Kevin Wolf geschrieben:
> This series adds optional feature lists to struct definitions in the
> QAPI schema and makes use of them to advertise the new behaviour of
> auto-read-only=on in file-posix.

Ping?
