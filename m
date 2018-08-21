Received: from eggs.gnu.org ([2001:4830:134:3::10]:44099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzRe-0000KM-Jp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzRZ-000359-Hv
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:43:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frzRZ-00034v-DE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 182E6804BAAD
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:43:05 +0000 (UTC)
Date: Tue, 21 Aug 2018 07:43:01 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821054301.ezfguhheryofu5un@sirius.home.kraxel.org>
References: <20180725092751.21767-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725092751.21767-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] vnc: remove deprecated TLS related
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

  Hi,

>   doc: switch to modern syntax for VNC TLS setup
>   vnc: remove support for deprecated tls, x509, x509verify options

Added to ui queue.

thanks,
  Gerd
