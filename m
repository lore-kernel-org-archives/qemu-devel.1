Received: from eggs.gnu.org ([2001:4830:134:3::10]:60322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dafYy-0002uE-Qf
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dafYt-0000PI-Sq
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dafYt-0000Ow-MH
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:58:31 -0400
Date: Thu, 27 Jul 2017 17:58:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170727095822.GF5117@lemon.lan>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
	<8760eiuxu5.fsf@dusky.pond.sub.org>
	<9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com>
	<871sp2gut9.fsf@dusky.pond.sub.org>
	<20170727091957.GC5117@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170727091957.GC5117@lemon.lan>
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <cleber@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Thu, 07/27 17:19, Fam Zheng wrote:
> On the other hand the iotests are more difficult to debug when things go wrong

s/iotests/python tests/
