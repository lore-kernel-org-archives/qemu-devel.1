Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDTew-0004AR-IJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDTes-0003fU-5P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:13:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDTer-0003cS-Ts
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:13:38 -0400
Date: Fri, 19 Oct 2018 13:13:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019121333.GN13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180823102502.28122-1-berrange@redhat.com>
	<20181019112250.GA19474@redhat.com>
	<a6c6768c-dbc1-e1be-fe94-3a354fa0cad0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6c6768c-dbc1-e1be-fe94-3a354fa0cad0@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Fri, Oct 19, 2018 at 02:00:21PM +0200, Paolo Bonzini wrote:
> On 19/10/2018 13:22, Daniel P. Berrang=C3=A9 wrote:
> > Copying Paolo, since this probably falls under the "misc patches"
> > maintainer bucket.
>=20
> I think we should define a "generic maintainer stuff" bucket where ever=
y
> maintainer is supposed to send patches with a Reviewed-by.  Maintainers
> are probably good enough at getting reviews by an appropriate person.
>=20
> (I am slowly trying to remove stuff from the misc bucket).

Ah, so you mean, any maintainer would be expected to directly send a
PULL for any "generic" patches they had collected acks for.

That would makes sense to me, since we don't seem to be making much
progress in getting all source files to have an explicit maintainer.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
