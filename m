Received: from eggs.gnu.org ([2001:4830:134:3::10]:51097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dNxub-00071U-HQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dNxua-0003AA-RB
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:56:25 -0400
Date: Thu, 22 Jun 2017 10:56:10 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170622085610.wasfoafo3b46iv4q@eukaryote>
References: <1498040351-6376-2-git-send-email-kchamart@redhat.com>
	<bdbe5523-b066-a2ef-9e46-ece40ff4060d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbe5523-b066-a2ef-9e46-ece40ff4060d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stephen@that.guru, armbru@redhat.com, mreitz@redhat.com

On Wed, Jun 21, 2017 at 06:49:02PM -0400, John Snow wrote:

[...]

> > * TODO (after feedback from John Snow):
> >    - Eric Blake suggested to consider documenting incremental backup
> >      policies as part of the section: "Live disk backup ---
> >      `drive-backup` and `blockdev-backup`"
> 
> Perhaps it could be mentioned, but hopefully I've covered it in some
> sufficient detail in the (now) docs/devel/bitmaps.md file; 

Yes, that doc is very useful.  That was my precise thought.

> I'm a little wary of duplicating efforts in this area, 

I share your wariness.

> but you've covered everything *else* in good detail here, so now my
> file is the odd one out.
> 
> I will leave this up to you, really. Perhaps it could be paid some lip
> service with a link to the other document? 

Yes, I was thinking of this, too -- just link to the 'bitmaps' document.

A quick side question here: Since upstream QEMU is converging onto
Sphinx, and rST, hope you mind if I convert docs/devel/bitmaps.md into
rST at somepoint, for consistency's sake.  I'll file a separate review,
anyway for that.  In the long term, all / most other documents would
also be converted.

> The detail in bitmaps.md is a little more verbose than the rest of
> this file, so if you include it wholesale it'd dwarf the rest of this
> document.
> 
> What do you think?

Yes, I fully agree with your suggestion.  I will simply link to the
detailed document you wrote, which I was thinking of anyhow.

Thanks for your comments!

-- 
/kashyap
