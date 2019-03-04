Received: from eggs.gnu.org ([209.51.188.92]:56896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0uMA-0000vE-Pd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0uMA-00086V-4G
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:38:38 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:49044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h0uM9-00081e-LD
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:38:38 -0500
Date: Mon, 4 Mar 2019 21:38:26 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190304203826.GA2995@t470p.stackframe.org>
References: <20190304180920.21534-1-svens@stackframe.org>
	<905f71d7-3df9-d738-3514-87a49c8aceb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905f71d7-3df9-d738-3514-87a49c8aceb0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Hi Eric,

On Mon, Mar 04, 2019 at 12:40:50PM -0600, Eric Blake wrote:
> On 3/4/19 12:09 PM, Sven Schnelle wrote:
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> 
> The commit header says "what" (good), but the commit body says nothing at
> all (generally, it should say "why"). If you give your reviewers a reason
> why it is good to use the new functions, it makes it easier to apply your
> patch.
> 
> Also, don't forget to send a 0/5 cover letter when sending a patch series;
> you can have git do this for you with 'git config format.coverletter auto'.
> https://wiki.qemu.org/Contribute/SubmitAPatch has more hints for improved
> patch handling.

Thanks, will keep this in mind, sorry. Should i resend the series?

Regards
Sven
