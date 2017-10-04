Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzf2y-0001i3-6G
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzf2x-00012U-GS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:28:52 -0400
Date: Wed, 4 Oct 2017 16:28:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171004082835.GE24018@lemon>
References: <1501165990-28033-1-git-send-email-ashijeetacharya@gmail.com>
	<CAJSP0QXXM1_dQSS=34wV+JMnSaqYpyxtptPW+2VrYy1OV109Tg@mail.gmail.com>
	<CAC2QTZY0P=TCkDuOByDuGwhqSYHC_LA=dZM1Odb9t628g-M8tw@mail.gmail.com>
	<CAJSP0QUgre0znYYdVwkEaef0u7N1PT+Mh3bL+JCopshuriyh2Q@mail.gmail.com>
	<CAC2QTZYb8hBOWvF+hrg24Z63SSxRySV2bhy+dj8vNEeUO-7Hfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZYb8hBOWvF+hrg24Z63SSxRySV2bhy+dj8vNEeUO-7Hfg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, 10/04 13:47, Ashijeet Acharya wrote:
> Fam: Ping?

Hi Ashijeet, looks like this patch doesn't apply to current master, could you
rebase and post another version?

Fam
