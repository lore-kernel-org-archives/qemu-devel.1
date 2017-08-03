Received: from eggs.gnu.org ([2001:4830:134:3::10]:49036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddHpu-00039O-93
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddHpt-0004Sr-Eb
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:14:54 -0400
Date: Thu, 3 Aug 2017 17:14:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803151445.GJ4456@dhcp-200-186.str.redhat.com>
References: <20170728164708.12202-1-eblake@redhat.com>
	<20170728164708.12202-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728164708.12202-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qemu-img: Sort sub-command names in
 --help
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
> 'amend' was the only sub-command not listed alphabetically;

Not completel true: create is the second one that is in the wrong place,
it should come after commit/compare/convert. Do you want to fix that
one, too?

> hoist it earlier, and separate the @end table block to make it easier
> to copy-and-paste the addition of future sub-commands.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Kevin
