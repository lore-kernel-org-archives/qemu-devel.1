Received: from eggs.gnu.org ([2001:4830:134:3::10]:42528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cikDs-0000yX-Ck
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cikDo-00064j-Sv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:01:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cikDo-00064X-NR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:01:52 -0500
Date: Tue, 28 Feb 2017 16:01:48 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170228160148.GK2720@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
	<2a8da4e5-d66d-502c-322b-ec942f250f40@msgid.tls.msk.ru>
	<20170228152240.6efc1fbc@bahia.lan>
	<4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for
 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On Tue, Feb 28, 2017 at 05:55:02PM +0300, Michael Tokarev wrote:
> 28.02.2017 17:22, Greg Kurz wrote:
> > On Tue, 28 Feb 2017 17:02:44 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> > 
> >> 28.02.2017 13:30, Greg Kurz wrote:
> >>> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:
> >>>
> >>>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   https://github.com/gkurz/qemu.git tags/cve-2016-9602-for-upstream
> >>>
> >>> for you to fetch changes up to c23d5f1d5bc0e23aeb845b1af8f996f16783ce98:  
> >>
> >> Greg, did you forget to push maybe? There's no tag "cve-2016-9602-for-upstream"
> >> and no object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98.
> >>
> > 
> > I had pushed actually and...
> > 
> > https://github.com/gkurz/qemu/commits/cve-2016-9602-for-upstream
> > https://github.com/gkurz/qemu/commit/c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
> 
> Interesting. Perhaps I've never worked with github before.
> It works when referring to particular commit like this.
> but the tag isn't visible in github UI, and neither the
> tag nor this commit ID is visible when cloning github
> repository locally. I wonder where's that.

Did Greg perhaps push the tag, but not the branch the commits & tag were
on ?   IIUC, if you don't push any branch holding the code, then the
commits & tags are in the repo, but essentially orphaned and thus
invisible to the github UI navigation.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
