Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTmup-0006S9-Ij
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTmuk-0002xR-NF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:52:27 -0500
Date: Wed, 18 Jan 2017 17:52:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118095218.GE6199@lemon>
References: <1484726609-16537-1-git-send-email-skiver.cloud.yzy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484726609-16537-1-git-send-email-skiver.cloud.yzy@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] gdbstub.c: update old error report
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Ziyue Yang <yzylivezh@hotmail.com>

On Wed, 01/18 16:03, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
> 
> Some updates from fprintf(stderr, ...) to error_report.

In the future, please use "git format-patch --cover-letter" and "git send-email
--thread" to make sure the patches form a thread. See also:

http://wiki.qemu.org/Contribute/SubmitAPatch

Fam
