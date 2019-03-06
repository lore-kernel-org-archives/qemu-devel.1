Received: from eggs.gnu.org ([209.51.188.92]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1dOx-0007hE-9o
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1dOw-0006cQ-FJ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:44:31 -0500
Date: Wed, 6 Mar 2019 15:34:24 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190306203424.2fwrmjfdzanbbzv2@dhcp-17-118.bos.redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
	<CAFEAcA-PErYY12Dn9Rnjb8avmtnTXUg-Taqa=HDkdYYBfDW07A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-PErYY12Dn9Rnjb8avmtnTXUg-Taqa=HDkdYYBfDW07A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/7] Python queue, 2019-02-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Mar 01, 2019 at 02:38:45PM +0000, Peter Maydell wrote:
> On Fri, 22 Feb 2019 at 19:41, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
> >
> >   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
> >
> > for you to fetch changes up to 8f1c89ec7443e4fa2cf106d8fa1c1c97b6ddeffb:
> >
> >   Acceptance tests: expect boot to extract 2GiB+ initrd with linux-v4.16 (2019-02-22 14:07:01 -0500)
> >
> > ----------------------------------------------------------------
> > Python queue, 2019-02-22
> >
> > Python:
> > * introduce "python" directory with module namespace
> > * log QEMU launch command line on qemu.QEMUMachine
> >
> > Acceptance Tests:
> > * initrd 4GiB+ test
> > * migration test
> > * multi vm support in test class
> > * bump Avocado version and drop ":avocado: enable"
> 
> 
> Hi -- this pull request appears to be signed with a GPG key that
> I've never seen before and which is signed only by itself.
> Could you arrange to get some more signatures on it, please ?
>

Hi Peter,

I've got 3 new signatures on that key.  Let me know if that's enough,
and if you have any other issues with that key or the PR.

> thanks
> -- PMM

Thank you!
- Cleber.
