Received: from eggs.gnu.org ([2001:4830:134:3::10]:56579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyfw0-0004fM-IF
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyfvz-00077G-G5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:45:52 -0400
Date: Wed, 21 Mar 2018 15:45:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180321154534.GU8551@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180321153124.5357-1-berrange@redhat.com>
	<880c56f0-0ae6-c579-5345-1f9637dcf07e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <880c56f0-0ae6-c579-5345-1f9637dcf07e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: drop moderated sheepdog mailing
 list from MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Mar 21, 2018 at 10:42:57AM -0500, Eric Blake wrote:
> On 03/21/2018 10:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > The sheepdog mailing list is setup to stop and queue messages from
> > non-subscribers, pending moderator approval. Unfortunately it seems
> > that the moderation queue is not actively dealt with. Even when messa=
ges
> > are approved, the sender is never added to the whitelist, so every
> > future mail the same sender continues to get stopped for moderation.
> >=20
> > MAINTAINERS entries should be responsive and not uneccessarily block
> > mails from QEMU contributors, so drop the sheepdog mailing list.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   MAINTAINERS | 1 -
> >   1 file changed, 1 deletion(-)
>=20
> Perhaps the sheepdog list would like to know what we are doing, along w=
ith a
> heads up that their list policy is unfriendly.  But I can't be the one =
to
> tell them - if I were to add the sheepdog list in cc, I'd get moderated=
.

I copied the other listed sheepdog maintainers on this patch so that they
would get the heads up & opportunity to object and / or talk to the list
admins to address it if desired.  We should give them a few days to
respond here before queue'ing this at least.

> It's annoyed me enough times that I agree with the change.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
