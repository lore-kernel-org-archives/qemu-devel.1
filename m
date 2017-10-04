Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dzf6p-0002mk-AZ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dzf6o-0004ET-Gp
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:32:51 -0400
MIME-Version: 1.0
In-Reply-To: <20171004082835.GE24018@lemon>
References: <1501165990-28033-1-git-send-email-ashijeetacharya@gmail.com>
	<CAJSP0QXXM1_dQSS=34wV+JMnSaqYpyxtptPW+2VrYy1OV109Tg@mail.gmail.com>
	<CAC2QTZY0P=TCkDuOByDuGwhqSYHC_LA=dZM1Odb9t628g-M8tw@mail.gmail.com>
	<CAJSP0QUgre0znYYdVwkEaef0u7N1PT+Mh3bL+JCopshuriyh2Q@mail.gmail.com>
	<CAC2QTZYb8hBOWvF+hrg24Z63SSxRySV2bhy+dj8vNEeUO-7Hfg@mail.gmail.com>
	<20171004082835.GE24018@lemon>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 4 Oct 2017 14:02:47 +0530
Message-ID: <CAC2QTZZqUDekZ+majTDaugp9YnPqZMay9tb5OLmn=eEKuhkp+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, Oct 4, 2017 at 1:58 PM, Fam Zheng <famz@redhat.com> wrote:

> On Wed, 10/04 13:47, Ashijeet Acharya wrote:
> > Fam: Ping?
>
> Hi Ashijeet, looks like this patch doesn't apply to current master, could
> you
> rebase and post another version?
>

Hello Fam,

I will try to do it over the weekend then and you can merge it next week
hopefully.

Ashijeet

>
> Fam
>
