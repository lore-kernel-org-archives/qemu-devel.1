Received: from eggs.gnu.org ([209.51.188.92]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hL6ag-00007B-Mt
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hL6af-0003cN-GF
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:45:06 -0400
Date: Mon, 29 Apr 2019 15:44:54 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190429134454.GB4675@paraplu>
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426221528.30293-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com, aliang@redhat.com, nsoffer@redhat.com, Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org, eblake@redhat.com

On Fri, Apr 26, 2019 at 06:15:28PM -0400, John Snow wrote:
> This just about rewrites the entirety of the bitmaps.rst document to
> make it consistent with the 4.0 release. I have added new features seen
> in the 4.0 release, as well as tried to clarify some points that keep
> coming up when discussing this feature both in-house and upstream.
> 
> Yes, it's a lot longer, mostly due to examples. I get a bit chatty.
> I could use a good editor to help reign in my chattiness.
> 
> It does not yet cover pull backups or migration details, but I intend to
> keep extending this document to cover those cases.
> 
> Please try compiling it with sphinx and look at the rendered output, I
> don't have hosting to share my copy at present. 

FWIW, here's a public rendering (with the "Alabaster" Sphinx theme) with
your v3 applied:

    https://kashyapc.fedorapeople.org/QEMU-Docs-v4.0.0-143-g1cb2ca0415/_build/html/docs/interop/bitmaps.html

Thanks for the overhaul.  Afraid, I've been just too swamped to be able
to look at this in detail, much as I'd love to.  I will slowly catch up.

    - - -

(Note to self: send to the list the text-to-rST converted QEMU docs
sitting locally on a Git branch.)

[...]

> I think this new layout reads nicer in the HTML format than the old
> one did, at the expense of looking less readable in the source tree
> itself (though not completely unmanagable. We did decide to convert it
> from Markdown to ReST, after all, so I am going all-in on ReST.)

[...]


-- 
/kashyap
