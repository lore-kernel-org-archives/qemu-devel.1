Received: from eggs.gnu.org ([2001:4830:134:3::10]:54781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXjCc-0006oU-LA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXjCb-0005En-UJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:19:54 -0400
Date: Tue, 26 Jun 2018 10:19:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180626081946.GA3964@dhcp-200-186.str.redhat.com>
References: <20180626080546.3626-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626080546.3626-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Pacify Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 26.06.2018 um 10:05 hat Markus Armbruster geschrieben:
> Markus Armbruster (2):
>   block-qdict: Pacify Coverity after commit f1b34a248e9
>   block/crypto: Pacify Coverity after commit f853465aacb

Thanks, applied to the block branch.

Kevin
