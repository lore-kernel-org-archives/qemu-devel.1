Received: from eggs.gnu.org ([2001:4830:134:3::10]:34707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnilx-0007y4-5M
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnilw-0004Tb-5F
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:29:41 -0400
Date: Tue, 14 Mar 2017 10:29:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314092931.GB3952@noname.str.redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA9JoOLtUJAVhXijjDVZ4iTH_kYc3r03zmq7R58BesO1Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9JoOLtUJAVhXijjDVZ4iTH_kYc3r03zmq7R58BesO1Jg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] Block layer fixes for 2.9.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 13.03.2017 um 19:05 hat Peter Maydell geschrieben:
> On 13 March 2017 at 15:54, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)
> >
> > are available in the git repository at:
> >
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to dcbf37ce41a52698550f8f8b2f14b5e6fee22d2d:
> >
> >   commit: Implement .bdrv_refresh_filename (2017-03-13 12:49:33 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer fixes for 2.9.0-rc1
> 
> We haven't had rc0 yet :-)

I was assuming that we'd just skip -rc0 then. Are we instead shifting
the release by a week or two?

Kevin
