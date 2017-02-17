Received: from eggs.gnu.org ([2001:4830:134:3::10]:55707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceect-00047q-BI
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceecs-0002Pj-3r
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:14:51 -0500
Date: Fri, 17 Feb 2017 10:14:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217091435.GB5338@noname.redhat.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
	<20170217005127.21010-2-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217005127.21010-2-nirsof@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Add tests for raw image
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 17.02.2017 um 01:51 hat Nir Soffer geschrieben:
> Add tests for creating raw image with and without the preallocation
> option.
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>

Looks good, but 175 is already (multiply) taken. Not making this a
blocker, but I just want to remind everyone to check the mailing list
for pending patches which add new tests before using a new number in
order to avoid unnecessary rebases for everyone. In general, it's as
easy as searching for the string "175.out" in the mailbox.

The next free one seems to be 177 currently.

Kevin
