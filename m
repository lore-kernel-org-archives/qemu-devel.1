Received: from eggs.gnu.org ([2001:4830:134:3::10]:35762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eo9VX-0001tQ-88
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eo9VT-00086B-7R
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eo9VT-000861-05
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:06:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FB0B4040858
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 15:06:58 +0000 (UTC)
Date: Tue, 20 Feb 2018 15:06:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180220150655.GM6021@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1519138892-12836-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519138892-12836-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Document --rtc-td-hack,
 --localtime and --startdate as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Feb 20, 2018 at 04:01:32PM +0100, Thomas Huth wrote:
> These options have been marked in a comment in qemu-options.hx as
> deprecated in 2009 already (see commit 1ed2fc1fa35fadc0d6), but we
> never informed the users about these deprecations. Let's catch up
> on that omission now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 13 +++++++++++++
>  vl.c          |  5 +++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
