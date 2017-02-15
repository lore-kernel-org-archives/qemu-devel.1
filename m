Received: from eggs.gnu.org ([2001:4830:134:3::10]:39749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce14Z-0000O4-Gn
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce14W-0007VE-De
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:00:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17111)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ce14W-0007Uh-7L
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:00:44 -0500
References: <20170215144246.17756-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <faa63719-e836-d15d-8f00-07b2d795da99@redhat.com>
Date: Wed, 15 Feb 2017 16:00:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170215144246.17756-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu-web] Add Andrea's virtual memory
 FOSDEM presentation to blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>



On 15/02/2017 15:42, Stefan Hajnoczi wrote:
> From: Stefan Hajnoczi <stefanha@gmail.com>
>=20
> Andrea's presentation touches on Transparent Huge Pages and post-copy
> live migration using userfaultfd for virtualization use cases.
>=20
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> ---
> I don't know jekyll or how the blog is set up.  Perhaps timestamps need
> to be updated in the post file.  Please fix up when applying.

Right, I only had to add

last_modified_at: 2017-02-15 15:49:00 +0100

to the header.  So this will be also a nice example of how to update a
post after the fact!

Paolo

> ---
>  _posts/2017-02-10-fosdem-presentations.md | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/_posts/2017-02-10-fosdem-presentations.md b/_posts/2017-02=
-10-fosdem-presentations.md
> index 7a0840f..d297c5f 100644
> --- a/_posts/2017-02-10-fosdem-presentations.md
> +++ b/_posts/2017-02-10-fosdem-presentations.md
> @@ -27,3 +27,7 @@ and the videos of their presentations are now availab=
le online, too:
>  * [Using NVDIMM under KVM -- Applications of persistent memory in
>     virtualization](https://fosdem.org/2017/schedule/event/iaas_usinvdu=
nd/)
>    by Stefan Hajnoczi
> +
> +* [20 years of Linux Virtual Memory -- From simple server workloads to=
 cloud
> +   virtualization](https://fosdem.org/2017/schedule/event/iaas_20yeali=
n/)
> +  by Andrea Arcangeli
>=20
