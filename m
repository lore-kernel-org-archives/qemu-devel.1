Received: from eggs.gnu.org ([2001:4830:134:3::10]:49987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cUccd-0004IR-Fs
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cUcca-00084A-D8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:05:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:19624 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cUccZ-00082X-SO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:05:04 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <442dcfe4-8704-2898-655e-da383a0caf76@virtuozzo.com>
Date: Fri, 20 Jan 2017 20:04:40 +0300
MIME-Version: 1.0
In-Reply-To: <20161214150840.10899-1-alex@alex.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>, nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>

About extents: is 32bit length enough? We will have to send 4096 for 
empty 16tb disk..


-- 
Best regards,
Vladimir
