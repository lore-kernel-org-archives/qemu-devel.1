Received: from eggs.gnu.org ([2001:4830:134:3::10]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJW1y-00033H-H3
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJW1w-0000ph-MW
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:53:54 -0500
Date: Tue, 28 Nov 2017 10:53:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171128025341.GA3242@lemon>
References: <20171123175747.2309-1-famz@redhat.com>
	<20171124163952.GD4010@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124163952.GD4010@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Workaround for the iotests
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com

On Fri, 11/24 17:39, Kevin Wolf wrote:
> Maybe the backtraces would help me understand the problem if they were
> actually there. :-)

Ouch, looks like git-tag(1) doesn't like to store # lines in the message.
Unfortunately I rebooted the laptop and didn't save the vim buffer, thinking it
is already in the message. But from another reply I think your understanding
matches how I interpret the backtraces.

Fam
