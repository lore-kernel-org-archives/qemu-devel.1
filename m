Received: from eggs.gnu.org ([2001:4830:134:3::10]:48431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTfmo-0008JB-Rz
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTfmk-0005TU-Qs
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:15:42 -0500
Date: Wed, 18 Jan 2017 10:15:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118021529.GC31883@lemon.Home>
References: <1484702885-11437-1-git-send-email-skiver.cloud.yzy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484702885-11437-1-git-send-email-skiver.cloud.yzy@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] gdbstub.c: fix GDB connection segfault
 caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>, Anthony Liguori <aliguori@us.ibm.com>

On Wed, 01/18 09:28, Ziyue Yang wrote:
> Also some updates from fprintf(stderr, ...) to error_report.

Looks like they belong to a separate patch.

Fam
