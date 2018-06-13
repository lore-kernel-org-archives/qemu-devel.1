Received: from eggs.gnu.org ([2001:4830:134:3::10]:33427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zI-0008UG-P8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zE-0005xo-JL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:00 -0400
Date: Wed, 13 Jun 2018 14:38:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613133850.GM24528@stefanha-x1.localdomain>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <1528866321-23886-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] Replace '-enable-kvm' with '-accel
 kvm' in docs and help texts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 07:05:19AM +0200, Thomas Huth wrote:
> The preferred way to select the KVM accelerator is to use "-accel kvm"
> these days, so let's be consistent in our documentation and help texts.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/COLO-FT.txt                  | 8 ++++----
>  docs/can.txt                      | 4 ++--
>  docs/multi-thread-compression.txt | 2 +-
>  docs/multiseat.txt                | 2 +-
>  docs/specs/tpm.txt                | 8 ++++----
>  hw/block/dataplane/virtio-blk.c   | 4 ++--
>  hw/scsi/virtio-scsi-dataplane.c   | 4 ++--
>  7 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIR5qAAoJEJykq7OBq3PIWLAH/1a6FjH2nmFqXr4saikAhrem
+aThMJjh36014I6fMdddK7B1oXmxrM4CTuwXxzd2i62ltKR2v2KjUkCjSZUY2p2D
VgDoNQyMTXnhYuWsp5TXjd004TZSr4pdPEpOoYp/GQslWAeFvF4iK+OBTESMDbiN
cBprcAxARTEdJow7vXJ0xju4cf2McwMZDmeZh+AeT79EKB7A3ThlNj0+XAG4tpAk
cAK+GL2xgZeOhBDlXsNTXAEv6CXf9rHLvtpNPlR490dzbycAOtf4ns41D9bG8oyT
Traa6ttjijzpbd79WVGPVQCFtcjlfrpM5OQLoxzq316QZDDsRQk8GRQ8X854GjY=
=TXST
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--
