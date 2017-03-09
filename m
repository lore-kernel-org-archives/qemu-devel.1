Received: from eggs.gnu.org ([2001:4830:134:3::10]:53389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clrnP-0000vo-4g
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 01:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clrnN-0006Wp-R4
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 01:43:31 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clrnN-0006Wh-Jq
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 01:43:29 -0500
Received: by mail-wr0-x231.google.com with SMTP id l37so38158771wrc.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 22:43:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170309013150.GK19967@umbus.fritz.box>
References: <20170308124955.35623-1-aik@ozlabs.ru>
	<CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
	<4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
	<20170309013150.GK19967@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Mar 2017 07:43:07 +0100
Message-ID: <CAFEAcA9QzBASyBELx7fxp1pexVaZfLRP6fKaZX63LTOzV=hZjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 9 March 2017 at 02:31, David Gibson <david@gibson.dropbear.id.au> wrote:
> Yes.  I've now fixed this in upstream libfdt, at Paolo's suggestion.
> Unfortunately, it came just after the 1.4.3 release.  I was just leery
> about making a new release and qemu pull so soon after the last one.
> Should I do that anyway?

Yes, I would go ahead and do that.

thanks
-- PMM
