Received: from eggs.gnu.org ([2001:4830:134:3::10]:48026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dG0V7-0003EM-Op
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dG0Uy-0001gz-FS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:05:13 -0400
Date: Wed, 31 May 2017 11:26:44 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170531092644.pdzckatv7u7pg36h@eukaryote>
References: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
	<df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
	<20170530202428.vtz3f6jopr74huzb@eukaryote>
	<6696ea97-8bf0-44b0-d515-e760f5ac4803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6696ea97-8bf0-44b0-d515-e760f5ac4803@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] live-block-ops.txt: Rewrite and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

On Tue, May 30, 2017 at 03:42:08PM -0500, Eric Blake wrote:
> On 05/30/2017 03:24 PM, Kashyap Chamarthy wrote:

[...]

> > Eric, do you have an opinion:  Now that I _do_ have the notes
> > available[*], do you think it is worth spelling out the invocation for
> > QMP `blockdev-{backup, mirror}`?  Or wait for later?
> 
> I liked how you compared drive-mirror and blockdev-mirror, but it's
> probably worth an invocation example in sections 12/15 in addition to
> "this is how the block version differs from the drive version".

Yes, will address it.

Thanks.

-- 
/kashyap
