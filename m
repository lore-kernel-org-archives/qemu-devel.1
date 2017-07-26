Received: from eggs.gnu.org ([2001:4830:134:3::10]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daOw6-0000ZA-MB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daOw3-0005NZ-A7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1daOw3-0005NC-3z
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:13:19 -0400
Date: Wed, 26 Jul 2017 19:13:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170726191223-mutt-send-email-mst@kernel.org>
References: <20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<20170726150810.3a48d5f0@nial.brq.redhat.com>
	<95a701f0-c693-e1f7-be52-36f05bfc856a@redhat.com>
	<20170726153020.4c20b279@nial.brq.redhat.com>
	<83edcc44-62ff-ff53-371d-efb4c0d10259@redhat.com>
	<20170726154343.122935dc@nial.brq.redhat.com>
	<20170726140459.GP7620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726140459.GP7620@redhat.com>
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 26, 2017 at 03:04:59PM +0100, Daniel P. Berrange wrote:
> We're unlikely to be deleting machine types (and the features they
> depend on) for as long as there's downstream vendors who need compat
> with that vintage of features.

.. and actually put in the manpower to maintain them :)

-- 
MST
