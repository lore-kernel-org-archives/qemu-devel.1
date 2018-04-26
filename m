Received: from eggs.gnu.org ([2001:4830:134:3::10]:41358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkpL-0008SB-7N
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkpH-0008SB-Ut
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:37:03 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkpH-0008RX-K3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:59 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23266.3638.876146.489411@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 18:36:54 +0100
In-Reply-To: <CAFEAcA9cumr=t7mRZ-9KtLMWAK-9nVGmRsnXjJ+pc899ePxfVg@mail.gmail.com>
References: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
	<CAFEAcA9cumr=t7mRZ-9KtLMWAK-9nVGmRsnXjJ+pc899ePxfVg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v9 00/16] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Alistair Francis <alistair.francis@wdc.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>

Peter Maydell writes ("Re: [PULL v9 00/16] xen: xen-domid-restrict improvements"):
> Hi -- my apply-pullreq script thinks this isn't a signed tag:
> 
> error: remotes/iwj/for-upstream.depriv-2: cannot verify a non-tag object of
> type commit. Does not appear to be a signed tag

It isn't.  It's not a tag at all.  It's a branch.

> We only apply signed-tag pull requests these days; could you
> create and sign a tag and resend the pullreq, please? (You
> only need to resend the cover letter, not the whole set of
> patches.)

I can do that.  Alternatively you could manually verify the signature
on my email and observe that it mentions the correct commit hash.

> (https://wiki.qemu.org/Contribute/SubmitAPullRequest
> is our process documentation on pull requests, but I think
> everything else with this one is fine.)

I read that.  It does not say that the pull request must refer to a
signed tag.  It says that the pull request must be signed, so I signed
my pull request by feeding the email body to gnupg.

A detailed explanation of why you want the pull request to be signed,
rather than for it to be an unsigned email referring to a signed tag,
is beyond the scope of this memo :-).

Anyway, would you like me to make a signed tag and send you an
unsigned email referring to it, then ?  Or will you use the signed
email ?

Regards,
Ian.
