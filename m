Received: from eggs.gnu.org ([2001:4830:134:3::10]:54614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dx5CJ-0008Cy-Ef
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dx5CF-00048o-I0
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dx5CF-00048V-CC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:47:47 -0400
Date: Wed, 27 Sep 2017 13:47:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170927054743.GB9292@lemon.lan>
References: <20170926110134.2786-1-famz@redhat.com>
	<d916ab4b-dd2e-3b54-64a7-bfc76c822b58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d916ab4b-dd2e-3b54-64a7-bfc76c822b58@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: test-block: Don't continue if
 build fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, 09/26 08:48, Eric Blake wrote:
> On 09/26/2017 06:01 AM, Fam Zheng wrote:
> > Report error and exit upon compiling error, otherwise the iotests output
> > will be pure noise.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/docker/test-block | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Queued, thanks.

Fam
