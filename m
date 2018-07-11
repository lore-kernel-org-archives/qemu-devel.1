Received: from eggs.gnu.org ([2001:4830:134:3::10]:54046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdCrt-000535-AI
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdCrp-0007TK-Sq
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:01:08 -0400
Date: Wed, 11 Jul 2018 13:00:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180711110055.GF4266@localhost.localdomain>
References: <20180710170041.875-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710170041.875-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] file-posix: specify expected
 filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 10.07.2018 um 19:00 hat John Snow geschrieben:
> Tighten which types of files we'll allow you to specify for the various
> file drivers (file, host_device, host_cdrom).

Thanks, applied to the block branch.

Kevin
