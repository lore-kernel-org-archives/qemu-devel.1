Received: from eggs.gnu.org ([2001:4830:134:3::10]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cpvHc-0003Bk-3O
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cpvHW-0007op-CW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cpvHW-0007oZ-6Q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:15:22 -0400
From: Juan Quintela <quintela@redhat.com>
Message-ID: <8760jbu434.fsf@secure.mitica>
Reply-To: quintela@redhat.com
Date: Mon, 20 Mar 2017 12:15:18 +0100
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] KVM call minutes for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>


Hi

After a long while, we have had a kvm call.

See the thread for the agenda for things that were discussed.  My notes
are a bit clear because I was also partipating.

Please, reply with more things.

- What to do with qemu to evolve?
  Making it more modular (seems to be a good idea)
  more configurable (decide what we compile in or not)
  * xen and kvm can already be compiled out
  * there are patches posted for tcg, but not upstream

- how widely use is kvmtool?

- Change to a different language?
  * what we want to achieve wit that?
    Better support to detect "errors"
    Less boilerplate code to have to write
    Easier language for writing emulation code

- Can we do anything better than more documentation for people that want
  to write a driver?

- Should we use more upstream libraries?  Should we develop more inside
  qemu?

- Object model?
  * Was QOM a good decision?  Better to move to glib model?

- Documentation?  What format are we going to use
  There are patches to be integrated.


- What can we do to help device model writers?

Thanks, Juan.
