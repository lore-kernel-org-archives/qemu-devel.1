Received: from eggs.gnu.org ([209.51.188.92]:45087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1vWy-0003Uy-Vn
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1vWj-0005WL-Ru
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:05:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1vWi-0005SF-2d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:05:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so17655990qtp.8
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:05:40 -0800 (PST)
Date: Thu, 7 Mar 2019 11:05:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190307110441-mutt-send-email-mst@kernel.org>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307145120.GF32268@redhat.com>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrangé wrote:
> The broadening of vhost-user support is useful with that in much the
> same way I imagine.

vhost user has more of an impact but is also a bigger maintainance
burden as clients are packaged, can be restarted etc individually.

-- 
MST
